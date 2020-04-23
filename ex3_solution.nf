/*
    read single reference file, and multiple transcript files (all files with transcripts prefix), align with blastn
    hint - using my_file = file('path_to_file) allows to define a global file which can be referenced from any process
 */

genome = file("data/genome_1.fa")
transcripts_ch = Channel.fromPath("data/transcripts_*.fa")

process blast_transcript_vs_genome{
    publishDir "blast_output"

    input:
    file genome
    file transcripts from transcripts_ch

    output:
    file output_file

    script:
    output_file = "${transcripts}_vs_${genome}.blast.txt"
    """
    blastn -subject $genome -query $transcripts > $output_file
    """
}