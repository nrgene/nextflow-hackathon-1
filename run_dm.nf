
publish_dir = "./denovomagic"
conf_file = file("$publish_dir/DenovoMagic_CONF1")
//stages = "ERROR_CORRECTION:DEBRUIJN_GRAPH_ASSEMBLY:BELIEF_PROPAGATION:MAPPER_SE:CONSENSUS_FINDING:MAPPER_LINKS:LINKER:SCAFFOLDING:ORDERING:ORDERING_REFINING:UNPHASED_SIMULATED_CONSENSUS_FINDING:HAPLOID_LINKER:HAPLOID_SCAFFOLDING:HAPLOID_ORDERING:HAPLOID_ORDERING_REFINING:PHASER:POLISH:PHASED_POLISH:CHROMOSOMES_CONSTRUCT:PHASED_CHROMOSOMES_CONSTRUCT:CREATE_HTML_REPORT"
//stages_arr = stages.split(':')
//println stages_arr

process prepare_first_stages_run {

    publishDir publish_dir , mode: 'copy', overwrite: true
    input:
    file conf_file

    output:
    file(conf_file)

    script:
//    just a try - I'm trying to remove the last 2 lines from the file
    """
    head -n -2 $conf_file > conf.tmp && mv conf.tmp $conf_file 
    """
}

process run_first_stages_run {
    echo true

    input:
    file conf_file

    script:
//    just a try - print the last lines from file - to verify it's the modified file
    """
    tail -3 $conf_file
    """
}