function hfun_bar(vname)
  val = Meta.parse(vname[1])
  return round(sqrt(val), digits=2)
end

function hfun_m1fill(vname)
  var = vname[1]
  return pagevar("index", var)
end

function lx_baz(com, _)
  # keep this first line
  brace_content = Franklin.content(com.braces[1]) # input string
  # do whatever you want here
  return uppercase(brace_content)
end

function hfun_homepage_list()::String
    # Get markdown files from /blog/
    list = readdir("blog")
    filter!(f -> endswith(f, ".md"), list)

    # Sort files by recency and get 10 first ones
    dates = [pagevar(joinpath("blog", f), "rss_pubdate") for f in list]
    perm = sortperm(dates, rev=true)
    idxs = perm[1:min(10, end)]

    # Create list of links
    io = IOBuffer()
    write(io, "<ul>")
    for (k,i) in enumerate(idxs)
        fi = "/blog/" * first(splitext(list[i])) * "/"
        write(io, """<li><a href="$fi">$(pagevar(joinpath("blog", list[i]), "title"))</a></li>\n""")
    end
    write(io, "</ul>")
    return String(take!(io))
end
