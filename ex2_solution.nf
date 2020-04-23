/*
 save result to file named after inputs (transcripts_a.fa_vs_genome_1.fa.blast.txt),
 publish result to out_dir "blast_output" (using publidshDir)
 */


genome_ch = Channel.fromPath("data/genome_1.fa")
transcripts_ch = Channel.fromPath("data/transcripts_a.fa")

process blast_transcript_vs_genome{
    publishDir "blast_output"

    input:
    file genome from genome_ch
    file transcripts from transcripts_ch

    output:
    file output_file

    script:
    output_file = "${transcripts}_vs_${genome}.blast.txt"
    """
    blastn -subject $genome -query $transcripts > $output_file
    """
}