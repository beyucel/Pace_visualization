filename=OUTPUT_4nodes_singlethread_full.csv


echo "chunks,samples,memory_usage,fit_time,predict_time,r_squared" > ${filename}

for n_chunk in 1 10 20 40 80 120 160 200 240 300 400 500 600 1000 
do
    for repeat in {1..4}
    do
        for samples in 8000
        do
            mfilename=mprof.dat
            mprof run --output ${mfilename} --include-children ./main.py --samples=${samples} --chunks=${n_chunk} --filename=${filename} --threads_per_worker=1 --n_workers=1
            memory_value=`python memory.py --filename=mprof.dat`
            sed -i "s/memory_value/${memory_value}/" ${filename}
            \rm -rf mprof.dat
	done
    done
done
