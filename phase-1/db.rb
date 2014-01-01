require 'fileutils'

class DB

  STORE_PATH = "/tmp/db-phase-1/"

  def initialize(store = 'no-name', shard = nil)
    shard ||= Time.now.to_i.to_s

    dir_path = File.join(STORE_PATH, store)
    @path    = File.join(dir_path, shard)
    FileUtils.mkdir_p(dir_path) if not File.exist?(dir_path)
    
    @data  = load_data
  end

  # Public: Lookup data by key
  #
  # Returns data if available (type unknown) or nil if not found
  def find(key)
    @data[key]
  end


  # Public: Retrieve all data from the store
  #
  # Returns a hash of all the data
  def all
    @data
  end

  # Public: Store data with a given key
  #
  # Returns nothing, but has side-effect of persisting data to
  # disk.
  def store(key, data)
    @data[key] = data
    flush
  end

  # Public: Delete data found at given key
  #
  # Returns nothing, but has side-effect of persisting data to
  # disk.
  def delete(key)
    @data.delete(key)
    flush
  end
  
  private
  # Private: Load data from disk if available, returns an empty
  #          store (hash) if nothing found
  #
  # Returns data un-marshalled from disk
  def load_data
    if File.exists?(@path)
      Marshal.load(File.open(@path, 'r').read)
    else
      {}
    end
  end

  # Private: write data to disk
  #
  # Returns nothing, but has side-effect of persisting data
  def flush
    File.open(@path, 'wb') { |f| f.write(Marshal.dump(@data)) }
  end

end
