function hfun_bar(vname)
    val = Meta.parse(vname[1])
    return round(sqrt(val), digits = 2)
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

trimext = first∘splitext

@delay function hfun_homepage_list()::String
    # Get markdown files' path from /blog/
    list = [joinpath("blog", f) for f in readdir("blog") if endswith(f, ".md")]

    # Get relevant page variables
    indx = [(p, pagevar(p,"rss_pubdate"), pagevar(p,"title")) for p in list]

    # Sort files by recency and get 10 first ones
#    display(indx)
#    sort!(indx, by=(p,d,t)->d, rev=true)
#    first!(indx, 10)
    sort!(list, by=f->pagevar(f, "rss_pubdate"), rev=true)
    list = first(list, 10)
    dates = [pagevar(f, "rss_pubdate") for f in list]
    perm = sortperm(dates, rev = true)
    idxs = perm[1:min(10, end)]

    # Create and return list of links
    io = IOBuffer()
    write(io, "<ul>")
    #for i in idxs
    for post in list
#        post = list[i]
        url = "/" * trimext(post) * "/"
        write(io, """<li><a href="$url">$(pagevar(post, "title"))</a></li>\n""")
    end
    write(io, "</ul>")
    return String(take!(io))
end
