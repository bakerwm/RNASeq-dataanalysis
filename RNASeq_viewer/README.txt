These R scripts are designed to draw coverage maps of input sequences in differenct libraries.

## Content
1. Copy the 2 R scripts "getCovData.R" and "getSeqCovFig.R" to your dir.
2. Create a directory named "Coverage", which should contain coverage files in the following 
format: 
with the filename: <Strain Name>_<Library Name>.coverage.<p/n>
example: H37Rv_45SE.coverage.n

#Strain	Position	Coverage
NC_000962.2     1       0
NC_000962.2     2       0

3. Create a input file including at least the follow columns:
<Seq ID>	<Strain Name>	<Length>	<Begin>	<End>	<Strand>

4. The last step is to modify the script "getSeqCovFig.R"
	(1) the name of input file. (Line-15)
	(2) the name of outpuf PDF. (Line22)
	(3) The number of bins on X-axis. (Line40)
<<<<<<< HEAD

5. Finally, Run the script" Rscript getSeqCovFig.R" and get the output in PDF format.
=======
>>>>>>> e406a98819321d799af85710722fe18f0f52d690
