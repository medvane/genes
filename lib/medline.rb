module Bio
  class MEDLINE < NCBIDB
    MONTH = {
      "Jan" => 1,
      "Feb" => 2,
      "Mar" => 3,
      "Apr" => 4,
      "May" => 5,
      "Jun" => 6,
      "Jul" => 7,
      "Aug" => 8,
      "Sep" => 9,
      "Oct" => 10,
      "Nov" => 11,
      "Dec" => 12,
      "Spr" => 3,
      "Sum" => 6,
      "Aut" => 9,
      "Win" => 12,
    }
    def initialize(entry)
      # PMID: 19900898. One MH could span in more than one lines.
      # In such cases, the second line is recognized as another MH rather than 
      # part of the first line. 
      # To fix this bug, each line should be checked whether it starts with a
      # tag (new item) or not (wrapped line of the preceding tag).
      # If it is a wrapped line of the preceding tag, the last character ("\n")
      # is replaced with a space before the current line is appended.
      @pubmed = Hash.new('')

      tag = ''
      entry.each_line do |line|
        with_tag = false # bug fix
        if line =~ /^\w/
          tag = line[0,4].strip
          with_tag = true # bug fix
        end
        if line.length > 6
          @pubmed[tag][-1] = " " if @pubmed[tag][-1] and with_tag == false # bug fix
          @pubmed[tag] += line[6..-1]
        end
      end
    end
    attr_reader :pubmed
    
    def jt
      @pubmed['JT'].gsub(/\s+/, ' ').strip
    end
    
    #TODO: PMID:12895469, Edyta-Krzymanska-Olejnik only last name. AU/FAU don't match
    def authors
      authors = []
      @pubmed['AU'].strip.split(/\n/).each do |author|
        name = author.split(/\s+/)
        suffix = nil
        if name.length > 2 && name[-2] =~ /^[A-Z]+$/
          suffix = name.pop
        end
        initials = name.pop
        author = {
          "last_name" => name[0], 
          "fore_name" => initials, 
          "initials" => initials, 
          "suffix" => suffix,
        }
        authors.push(author)
      end
      fau = @pubmed['FAU'].strip.split(/\n/)
      fau.each_index do |index|
        last = authors[index]["last_name"]
        suffix = authors[index]["suffix"]
        fore = fau[index].gsub(/^#{last},\s+/, "").gsub(/\s+#{suffix}$/, "")
        authors[index]["fore_name"] = fore
      end
      return authors
    end

    def major_descriptors
      #@pubmed['MH'].strip.split(/\n/).select {|m| m.match(/\*/)}.map {|m| m.gsub(/\/.+$/, "")}
      mh.select {|m| m.match(/\*/)}.map {|m| m.gsub(/\*|\/.+$/, "")}
    end

    def pub_month
      MONTH[dp[5, 3]] || 1
    end

    def pub_day
      if dp[9,2] && dp[9,2].match(/^\d+$/)
        dp[9,2]
      else
        1
      end
    end

    def pubdate
      sprintf("%04d-%02d-%02d", year || 0, pub_month || 0, pub_day || 0)
    end

    def ellipsis_jt
      if jt.length > 236
        jt[0 .. 235] + "..."
      else
        jt
      end
    end
  end
end