dirs=$(ls -l | grep "^d" | awk '{print $9}')
for dir in $dirs; do
  cd $dir
  count=$(find . -type f -name "*" | wc -l)
  echo "$dir: $count"
  cd ..
done