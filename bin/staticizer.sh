#!/bin/bash - 

set -o nounset                              # Treat unset variables as an error

prog=$1
base_name=$(basename $prog)

lib_name(){
    awk '
    BEGIN{
        out=""
    }/^.*[^ ]\.so.*[^ ] => [^(]+.*$/{
        if (NF == 4) {
            out = out " " $3
            #print "LD" out "\\n"
            if($3 == "not")
                { 
                    out = $0 "\n"
                    exit(1);
                }
            }
    }
    END{
        print out
    }'
}

libs=`ldd "$prog" | lib_name`


if [ $? != "0" ] ; then
    echo "$libs"
    exit 1
fi


set -e #stop on first error

dir=$(mktemp -d)
for i in $libs ; do
    cp $i $dir
done
cp $prog $dir

pushd $dir
tar_name=${base_name}-psudostatic.tar.gz 
tar -zcf $tar_name *
popd

cp $dir/$tar_name .

divider="_ARCH_"

extractor="#!/bin/bash\\n
TMPDIR=\$(mktemp -d)\\n
ARCHIVE=\`awk '/^ $divider/ {print NR + 1; exit 0; }' \$0\`\\n
tail -n+\$ARCHIVE \$0 | tar xzv -C \$TMPDIR\\n
pushd \$TMPDIR\\n
LD_LIBRARY_PATH=. ./$base_name\\n
popd\\n
rm -rf \$TMPDIR\\n
exit 0\\n
$divider
"

cat <(echo -e $extractor) $tar_name > $base_name-psudostatic
chmod u+x $base_name-psudostatic
rm -rf $dir $tar_name
