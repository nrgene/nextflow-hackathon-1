/*
    align specified genome/transcript pairs simultaneously (from json file)
    align each transcript file to its genome
    for example, align transcripts_a to genome_1
                       transcripts_b to genome_2
 */

genome_transcripts_tuples = params.inputs

Channel.from(genome_transcripts_tuples)
        .map { genome_id, genome_file, transcript_file -> tuple(genome_id, file(genome_file), file(transcript_file))}
        .set { genome_transcripts_tuples_ch }


process blast_transcript_vs_genome{
    publishDir "blast_output"
    container "biocontainers/blast:v2.2.31_cv2"

    input:
    set val(genome_id), file(genome), file(transcripts) from genome_transcripts_tuples_ch

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
    container "biocontainers/blast:v2.2.31_cv2"
    
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