
module BrowserDetectHelper

  # useful method to render parts of the site only when a certain browser is detected.
  # e.g. <% if browser_is('mozilla') %> blah. <% end %>
  
  def browser_is name
    name = name.to_s.strip
    return true if browser_name == name
    return true if name == 'mozilla' && browser_name == 'gecko'
    return true if name == 'ie' && browser_name.index('ie')
    return true if name == 'webkit' && browser_name == 'safari'
  end

  # returns the browser name in a readable form.
  
  def browser_name
    @browser_name ||= begin

      ua = request.env['HTTP_USER_AGENT'].downcase
      
      if ua.index('msie') && !ua.index('opera') && !ua.index('webtv')
        'ie'+ua[ua.index('msie')+5].chr
      elsif ua.index('gecko/') 
        'gecko'
      elsif ua.index('opera')
        'opera'
      elsif ua.index('konqueror') 
        'konqueror'
      elsif ua.index('applewebkit/')
        'safari'
      elsif ua.index('mozilla/')
        'gecko'
      end
    
    end
  end
  
  # returns the user operating system
  # only Windows, Linux, Macintosh or unknown
  
  def user_os_simple
    ua = request.env['HTTP_USER_AGENT'].downcase
    return "Windows" if ua.index('win')
    return "Linux" if ua.index('Linux')
    return "Macintosh" if ua.index('Macintosh')
    return "unknown"
  end
  
  # tries to be more specific with the user os.
  # supporting: WinXP,W2000,Win7,Vista,W2003,Linux,Mac,Win98,WinNT,Win95
  # TODO: still have to do this. maybe get some clue from here: http://priyadi.net/wp-content/plugins/browsniff.txt
  
  def user_os_complex
  end
  
  def browser_version
    if browser_is('ie')
      return request.env['HTTP_USER_AGENT'].match(/^.*?MSIE ([0-9]{1}.[0-9]){1}.*?/)[1]
    end
    if browser_is('mozilla')
      return request.env['HTTP_USER_AGENT'].match(/^.*?Firefox\/([0-9]{1}.[0-9]){1}.*?/)[1]
    end
    if browser_is('webkit')
      # TODO: safari version extraction. plus distinction between chrome and safari.
      return "12"
    end
  end
  
  

end