/*
    concatenate outputs into a single output file, and publish this output file
    add -outfmt 6 to blastn command, to get a more summarized output
    you will need to save the output of blast_transcript_vs_genome into a channel, and then merge it's results
    which channel operator will you use?
    publish the merged output
 */

genome = file("data/genome_1.fa")
transcripts_ch = Channel.fromPath("data/transcripts_*.fa")

process blast_transcript_vs_genome{
    input:
    file genome
    file transcripts from transcripts_ch

    output:
    file output_file into blast_ch

    script:
    output_file = "${transcripts}_vs_${genome}.blast.tsv"
    """
    blastn -subject $genome -query $transcripts -outfmt 6 > $output_file
    """
}

process merge{
    publishDir "blast_output"

    input:
    file blast_files from blast_ch.collect()

    output:
    file output_file

    script:
    output_file = "merged_output.blast.tsv"
    """
    cat $blast_files > $output_file 
    """
}