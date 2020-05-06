reads_ch = Channel.fromPath("$params.reads_pp/*")
dm_conf = file(params.dm_conf)
se_conf = file(params.se_conf)
mp_conf = file(params.mp_conf)
out_dir = params.out_dir

dm_pipeline = '/opt/nrgene/denovomagic/DenovoMagic_v2.12.0/DenovoMagic2/RunDenovoMagic2.pl'

process denovomagic {
  echo true
  container '665945310045.dkr.ecr.us-east-1.amazonaws.com/denovomagic:v2.12.2'
  publishDir out_dir, mode: 'copy'


  input:
  file(reads_files) from reads_ch.collect()
  file dm_conf
  file se_conf
  file mp_conf

  output:
  file '*' into denovomagic_out_ch

  script:
  """
  #dryrun
  perl $dm_pipeline $dm_conf
  #run
  perl $dm_pipeline $dm_conf -exec
  """
}