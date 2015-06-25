# Reciprocal Best Hits

## criteria
1. select blast hits with Identity > 70%

## example

1. db, 3 genomes (t1=H37Rv, t2=H37Rv_new, t3=H37Ra, first 100 genes)

t1.ffn
t1.faa
t2.ffn
t2.faa
t3.ffn
t3.faa

2. run blast

```
perl bin/rbh_run_pairs.pl -i example -o output -p 2 ffn

perl binrbh_run_pairs.pl -i example -o output -p 2 ffn
```

Data in output:

a_vs_b.out
b_vs_a.out
a_vs_b.bestreciprocal
a_vs_b.homolist


3. summary

```
$ perl bin/rbh_stat.pl -d example -o output ffn

ID      t1.ffn  t2.ffn  t3.ffn
t1.ffn  100     95      96
t2.ffn  -       100     96
t3.ffn  -       -       100

$ perl bin/rbh_stat.pl -d example -o output faa

ID      t1.faa  t2.faa  t3.faa
t1.faa  100     94      96
t2.faa  -       100     95
t3.faa  -       -       100

```
