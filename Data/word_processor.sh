word_list=$1
i=1
cat $1 > word_list.txt
word_count=$(wc -w word_list.txt | cut -d ' ' -f 1)
touch i1.txt
while [ $i -le $word_count ]
do
	word=$(cut -d ' ' -f $i word_list.txt)
	echo -n "$word," >> i1.txt
	i=`expr $i + 1`
done
i=1
rm -rf word_list.txt
touch i2.txt
while [ $i -le $word_count ]
do
	j=`expr $i + 1`
	word=$(cut -d ',' -f $i i1.txt)
	count=0
	while [ $j -le $word_count ]
	do
		other_words=$(cut -d ',' -f $j i1.txt)
		if [ "$word" = "$other_words" ]
		then
			count=`expr $count + 1`
		fi
		j=`expr $j + 1`
	done
	if [ $count -lt 2 ]
	then
		echo "$word" >> i2.txt
	fi
	i=`expr $i + 1`
done
rm -rf i1.txt
sort i2.txt > i3.txt
rm -rf i2.txt
i=1
while [ $i -le $word_count ]
do
	word=$(head -$i i3.txt | tail -1)
	if [ $i -ne $word_count ]
		then
			echo -n "$word, "
		else
			echo "$word"
		fi 
	i=`expr $i + 1`
done
rm -rf i3.txt

