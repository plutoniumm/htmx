
# qol function to check if str 1 is in array 2
function has(){
  inside=false;
  for i in "${@:2}"; do
    if [ "$i" == "$1" ]; then
      inside=true;
      break;
    fi
  done
  echo $inside;
}

ignores=( "readme.md" )
function seal(){
  # convert dir into a single txt file
  dir="$1"
  if [ -z "$dir" ]; then
    echo "Usage: seal <dir>";
    return 1;
  fi
  if [ ! -d "$dir" ]; then
    echo "Error: $dir is not a directory";
    return 1;
  fi

  dir="${dir%/}";
  echo "Sealing $1 into $dir.txt";
  # clean dir
  rm -f "$dir.txt";
  for file in $(find "$dir" -type f); do
    if [ -f "$file" ]; then
      # ignore list
      if [ $(has $(basename "$file") "${ignores[@]}") == true ]; then
        continue;
      fi

      # name does not include the dir
      name="${file#$dir/}";
      # we'll use #-# as a separator during unseal
      echo "\n\n#-# $name" >> "$dir.txt";
      cat "$file" >> "$dir.txt";
    fi
  done
}


nobuild=("assets" ".git" "build")
function build(){
  mkdir -p build;
  rm -rf build/* ./**/node_modules;

  for dir in $(find . -type d -d 1); do
    if [ -d "$dir" ]; then
      # ignore list
      if [ $(has $(basename "$dir") "${nobuild[@]}") == true ]; then
        continue;
      fi

      seal "$dir";
      mv "$dir.txt" "build/$(basename $dir).txt";
    fi
  done

  cp ./create ./build/create;
  echo "Built!";
}

function deploy(){
  build;
  gh-pages -d build -b dist;
}

"$@"