terraform console

> upper("Hello 30daysofawsteeraaform")
"HELLO 30DAYSOFAWSTEERAAFORM"
> lower("HelloLowerFucntion")
"hellolowerfucntion"
> trim(" "," aws tf ")
""
> trim(" aws tf "," ")
"aws tf"
> trim("awstf ","f")
"awstf "
> trim("aws tf","f")
"aws t"
> replace("hello world","o","f")
"hellf wfrld"
> substr("hello",0,3)
"hel"
> max(5,10,12)
12
> min(4,5,1)
1
> abs(-9370)
9370

<!-- COLLECTION -->

> length([1,2,3,4])
4
> concat([1,2,3],[4,3,5])
[
  1,
  2,
  3,
  4,
  3,
  5,
]
> merge({a=1},{b=2})
{
  "a" = 1
  "b" = 2
}
> toset(["a","b","a"])
toset([
  "a",
  "b",
])
> tonumber("54")
54
> tostring(23)
"23"
> timestamp()
"2026-11-16T10:55:18Z"
> formatdate("DD-MM-YYYY",timestamp())
"16-11-2026"