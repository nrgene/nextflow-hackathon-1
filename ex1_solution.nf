/*
read single reference file, and single transcrips file, align with blast
hardcoded inputs:
 "data/genome_1.fa"
 "data/transcripts_a.fa"
 */
genome_ch = Channel.fromPath("data/genome_1.fa")
transcripts_ch = Channel.fromPath("data/transcripts_a.fa")

process blast_transcript_vs_genome{
    echo true

    input:
    file genome from genome_ch
    file transcripts from transcripts_ch

    script:
    """
    blastn -subject $genome -query $transcripts
    """

}
