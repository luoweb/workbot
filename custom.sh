#!/bin/bash

# 批量将 mini_claw 重命名为 work_bot（不区分大小写）

baseDir=$(cd `dirname $0`;pwd)
cd $baseDir
WORK_DIR=$baseDir

cd "$WORK_DIR" || exit 1

echo "${execStartTime} Exe Dir: $baseDir"
xsed='sed -i'
system=`uname`
if [ "$system" == "Darwin" ]; then
  echo "This is macOS"
  xsed="sed -i .bak"
else
  echo "This is Linux"
  xsed='sed -i'
fi


# 1. 重命名文件和目录
for item in $(find . -iname "*mini_claw*"); do
    new_name=$(echo "$item" | sed -E 's/[mM][iI][nN][iI]_[cC][lL][aA][wW]/work_bot/g')
    if [ "$item" != "$new_name" ]; then
        echo "Renaming: $item -> $new_name"
        mv "$item" "$new_name"
    fi
done

# 2. 修改文件内容中的引用（不区分大小写匹配）
find . -type f \( -name "*.py" -o -name "*.yaml" -o -name "*.yml" -o -name "*.md" \) -exec $xsed -E 's/[mM][iI][nN][iI]_[cC][lL][aA][wW]/work_bot/g' {} \;
find . -type f \( -name "*.py" -o -name "*.yaml" -o -name "*.yml" -o -name "*.md" \) -exec $xsed -E 's#lfenghx#roweb#g' {} \;

echo "Done!"
