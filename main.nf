#!/usr/bin/env nextflow

nextflow.enable.dsl=2

include {FT} from './processes/FT'
include {extract} from './processes/extract'


workflow {
  File outpath = new File(params.output)
  if (!outpath.exists())
    outpath.mkdirs()
  Channel.fromPath(params.input) | extract | FT 
}