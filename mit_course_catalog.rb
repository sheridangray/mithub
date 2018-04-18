require 'csv'
require 'open-uri'
require 'nokogiri'

@target_file = 'mit_course_15.tsv'

doc = Nokogiri::HTML(open("http://catalog.mit.edu/subjects/15/"))
elements = doc.css("#sc_sccoursedescs")

CSV.open(@target_file, 'wb', col_sep: "\t") do |csv|
  csv << ["School", "Course", "Category", "Class Title", "Prerequisites", "Terms", "Hours", "Description", "Professor"] 


  elements.children.each do |element|
    if element.name == "h2"
      @category = element
    else

      course_title = element.css(".courseblocktitle").text
      course_prereqs = element.css(".courseblockextra").css(".courseblockprereq").text
      course_terms = element.css(".courseblockextra").css(".courseblockterms").text
      course_hours = element.css(".courseblockextra").css(".courseblockhours").text
      course_description = element.css(".courseblockdesc").text
      course_professor = element.css(".courseblockinstructors").css("span").css("i").text

      csv << ["MIT", "Course 15", @category, course_title, course_prereqs, course_terms, course_hours, course_description, course_professor]  
      # puts "#{@category.text} #{course_title.text} #{course_prereqs.text} #{course_terms.text} #{course_terms.text} #{course_description.text} #{course_professor}"
    end
  end
end