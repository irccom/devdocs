require 'octopress-hooks'
require 'git'

module Jekyll
    class IRCPage < Octopress::Hooks::Page

        attr_accessor :g

        def pre_render(page)
            # set raw markdown data
            page.data["rawmd"] = page.content.dup # .dup passes duplicate of the string, stops modifying the original ;)
            page.data["rawmd"].gsub! "{% include numeric-format-header.html %}", ""
            page.data["rawmd"].gsub! "{% include command-format-header.html %}", ""

            # set file commit date/time
            if page.site.config["pregit"] then
                if @g == nil then
                    @g = Git.open(Dir.pwd)
                end
                page_file = File.join(".", page.dir, page.name)
                commit = @g.log().object(page_file).first
                page.data["commit-id"] = "fake"
                earliest_date = Time.now
                if commit then
                    earliest_date = commit.date
                    page.data["commit-id"] = commit.sha
                end
                page.data["commit-date"] = earliest_date
            end
        end

      end
end
