# there is proxy between client and real object 
# what is use of proxy -> you can restrict access before it actually went to real object
# what is differece between proxy vs decorator, proxy follows same interface as real object while decoractor interface can be different 

# ================================
# Proxy Design Pattern - Ruby
# ================================

# SUBJECT
# This is the common interface that both the RealObject
# and the Proxy will implement.
class Image
  def display
    raise NotImplementedError, "Subclasses must implement display method"
  end
end


# REAL SUBJECT
# This is the actual object that does the real work.
# Creating this object is expensive (loading from disk).
class RealImage < Image
  def initialize(filename)
    @filename = filename
    load_from_disk
  end

  def display
    puts "Displaying #{@filename}"
  end

  private

  def load_from_disk
    puts "Loading #{@filename} from disk..."
  end
end


# PROXY
# Controls access to the RealImage.
# It creates the RealImage only when needed (lazy loading).
class ImageProxy < Image
  def initialize(filename)
    @filename = filename
    @real_image = nil
  end

  def display
    # Lazy initialization
    @real_image ||= RealImage.new(@filename)
    @real_image.display
  end
end


# CLIENT CODE
# The client works with the Image interface
# and does not know whether it's using a proxy or a real object.
image = ImageProxy.new("photo.png")

puts "Image created, but not loaded yet."
puts "--------------------------------"
puts "First call to display:"
image.display
puts "--------------------------------"
puts "Second call to display:"
image.display




# other example 

# =========================================
# Proxy Design Pattern - Caching Proxy
# YouTube Example (Ruby)
# =========================================

# -----------------------------------------
# SUBJECT (Interface)
# -----------------------------------------
class ThirdPartyYouTubeLib
  def list_videos
    raise NotImplementedError
  end

  def get_video_info(id)
    raise NotImplementedError
  end

  def download_video(id)
    raise NotImplementedError
  end
end


# -----------------------------------------
# REAL SUBJECT
# -----------------------------------------
# Simulates a real YouTube service.
# Network calls are expensive and slow.
class ThirdPartyYouTubeClass < ThirdPartyYouTubeLib
  def list_videos
    puts "Fetching video list from YouTube API..."
    sleep(1) # simulate network delay
    ["Video 1", "Video 2", "Video 3"]
  end

  def get_video_info(id)
    puts "Fetching info for video #{id} from YouTube API..."
    sleep(1) # simulate network delay
    { id: id, title: "Video #{id}", duration: "10 mins" }
  end

  def download_video(id)
    puts "Downloading video #{id} from YouTube..."
    sleep(2) # simulate download delay
    puts "Video #{id} downloaded"
  end
end


# -----------------------------------------
# PROXY (Caching Proxy)
# -----------------------------------------
# Caches results to reduce network usage.
class CachedYouTubeClass < ThirdPartyYouTubeLib
  def initialize(service)
    @service = service
    @list_cache = nil
    @video_cache = {}
    @need_reset = false
  end

  def list_videos
    if @list_cache.nil? || @need_reset
      @list_cache = @service.list_videos
    else
      puts "Returning cached video list"
    end
    @list_cache
  end

  def get_video_info(id)
    if !@video_cache.key?(id) || @need_reset
      @video_cache[id] = @service.get_video_info(id)
    else
      puts "Returning cached info for video #{id}"
    end
    @video_cache[id]
  end

  def download_video(id)
    puts "Proxy forwarding download request"
    @service.download_video(id)
  end
end


# -----------------------------------------
# CLIENT
# -----------------------------------------
# Works with the interface, not caring whether
# it uses a real service or a proxy.
class YouTubeManager
  def initialize(service)
    @service = service
  end

  def render_video_page(id)
    info = @service.get_video_info(id)
    puts "Rendering video page: #{info[:title]}"
  end

  def render_list_panel
    list = @service.list_videos
    puts "Rendering list panel: #{list.join(', ')}"
  end

  def react_on_user_input
    render_video_page(1)
    render_list_panel
    render_video_page(1)   # Cached
    render_list_panel      # Cached
  end
end


# -----------------------------------------
# APPLICATION SETUP
# -----------------------------------------
class Application
  def self.init
    youtube_service = ThirdPartyYouTubeClass.new
    youtube_proxy  = CachedYouTubeClass.new(youtube_service)
    manager = YouTubeManager.new(youtube_proxy)

    manager.react_on_user_input
  end
end


# Run application
Application.init

