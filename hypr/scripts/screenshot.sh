grim -g "$(slurp)" - | magick png:- -shave 1x1 png:- | swappy -f -
