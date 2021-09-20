# frozen_string_literal: true

# perform app logic and display result
class Batting
  attr_accessor :data, :result

  def initialize(data)
    @data = data
    @result = []
  end

  def process
    data.each do |row|
      row = cleanup(row)
      next if row.empty?

      existing = record(row)[0]
      existing.nil? ? add(row) : update(row, existing)
    end

    @result = @result.sort_by { |r| r[:batting_average] }
  end

  def display
    puts Hirb::Helpers::AutoTable.render(
      result.reverse,
      fields: result[0]&.keys,
      headers: {
        player_id: 'playerID',
        year_id: 'yearID',
        team_names: 'Team name(s)',
        batting_average: 'Batting Average'
      }
    )
  end

  private

  def cleanup(row)
    row.to_h.transform_keys(&:to_sym)
  rescue NoMethodError
    puts "Warning: invalid row - excluding #{row.inspect}"
    []
  end

  def update(row, existing)
    return if existing.nil?

    existing[:team_names] = "#{existing[:team_names]}, #{CsvImport.team_name_from(row[:teamID], row[:yearID])}"
    existing[:batting_average] = ((batting_average(row[:H], row[:AB]) + existing[:batting_average]) / 2).round(3)
  end

  def add(row)
    @result << {
      player_id: row[:playerID],
      year_id: row[:yearID],
      team_names: CsvImport.team_name_from(row[:teamID], row[:yearID]),
      batting_average: batting_average(row[:H], row[:AB]).round(3)
    }
  end

  def batting_average(hits, at_bats)
    at_bats = at_bats.to_f
    return 0 unless at_bats.positive?

    hits.to_f / at_bats
  end

  def record(row)
    @result.select { |res| res[:player_id] == row[:playerID] && res[:year_id] == row[:yearID] }
  end
end
