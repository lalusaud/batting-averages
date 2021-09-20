# frozen_string_literal: true

require 'csv'

# handles CSV import operations
class CsvImport
  attr_reader :file, :filters

  def self.teams
    @teams ||= CSV.read('Teams.csv', headers: true)
  end

  def self.team_name_from(team_id, year_id)
    teams.select { |team| team['teamID'] == team_id && team['yearID'] == year_id }[0]['name']
  rescue StandardError
    "- #{team_id} -"
  end

  def self.team_id_from(team_name)
    teams.select { |team| team['name'].downcase == team_name.downcase }[0]['teamID']
  rescue StandardError
    "- #{team_name} -"
  end

  def initialize(options)
    @file = options.fetch :file, nil
    @filters = options.slice(:years, :teams)
  end

  def read
    raise 'Input file not found! please add -f option to add input file.' if @file.nil?

    File.open(@file) do |filepath|
      @data = CSV.parse(filepath, headers: true)
    end

    filter_data
  rescue StandardError => e
    puts "Error: #{e.message} Goodbye!"
    exit
  end

  private

  def filter_data
    return @data if filters.empty?

    filters.each do |type, values|
      values = values.split(',').map(&:strip)
      next unless %i[years teams].include?(type) && values.any?

      send("filter_#{type}", values)
    end
    @data
  end

  def filter_years(values)
    filter_body(values, 'yearID')
  end

  def filter_teams(values)
    filter_body(values, 'teamID')
  end

  def filter_body(values, field)
    new_data = []
    values.each do |value|
      match = field == 'yearID' ? value : self.class.team_id_from(value)
      new_data << @data.select { |row| row[field] == match }
    end
    @data = new_data.flatten(1)
  end
end
