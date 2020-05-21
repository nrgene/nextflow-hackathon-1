
publish_dir = "./denovomagic" //todo replace with running directory
conf_file = file("$publish_dir/DenovoMagic_CONF1")

//default values
params.stages_first_run = 'ERROR_CORRECTION:DEBRUIJN_GRAPH_ASSEMBLY:BELIEF_PROPAGATION:MAPPER_SE:CONSENSUS_FINDING:MAPPER_LINKS:LINKER:SCAFFOLDING:ORDERING:ORDERING_REFINING:UNPHASED_SIMULATED_CONSENSUS_FINDING'
params.stages_second_run = 'HAPLOID_LINKER:HAPLOID_SCAFFOLDING:HAPLOID_ORDERING:HAPLOID_ORDERING_REFINING:PHASER:POLISH:PHASED_POLISH:CHROMOSOMES_CONSTRUCT:PHASED_CHROMOSOMES_CONSTRUCT:CREATE_HTML_REPORT'

process split_cond_and_run_part_1 {
    publishDir publish_dir
    echo true

    input:
    file(conf_file)

    output:
    file(conf_file_2) into conf_second_run_ch
    //first run output

    script: //last lines should be replaced with running dm
    conf_file_1 = "${conf_file}.1"
    conf_file_2 = "${conf_file}.2"
    """
    sed 's/STAGES .*/STAGES                  := ${params.stages_first_run}/' $conf_file > $conf_file_1
    sed 's/STAGES .*/STAGES                  := ${params.stages_second_run}/' $conf_file > $conf_file_2
    sed -i 's/RUN_NUMBER .*/RUN_NUMBER                  := 2/' $conf_file_2
    mv -f $conf_file_1 $conf_file
    cat $conf_file | grep "STAGES "
    cat $conf_file | grep "RUN_NUMBER "
    """
    //todo need increment RUN_NUMBER by one in second file
}

process run_part_2 {
    publishDir publish_dir
    echo true

    input:
    file(conf_file_2) from conf_second_run_ch
    file(conf_file)

//    output:
    //second run output

    script: //last lines should be replaced with running dm
    """
    mv -f $conf_file_2 $conf_file
    cat $conf_file | grep "STAGES "
    cat $conf_file | grep "RUN_NUMBER "
    """
}