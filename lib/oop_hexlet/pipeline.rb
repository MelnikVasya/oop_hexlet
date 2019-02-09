module Pipeline
  def self.main
    file_paths = Dir.glob('*', File::FNM_DOTMATCH)
                    .find_all { |path| path.start_with?('.') }
                    .sort

    midle_path = midle(file_paths)
    plural_midle_path = plural(midle_path, 's')

    puts plural_midle_path.upcase
  end

  def self.midle(list)
    middle_index = (list.size / 2).round
    list[middle_index]
  end

  def self.plural(str, symbol)
    str.end_with?('s') ? str : "#{str}#{symbol}"
  end
end
