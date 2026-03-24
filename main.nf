#!/usr/bin/env nextflow

/*
* QC Pipeline
*/

nextflow.enable.dsl=2

// --- Parameters ---
params.input   = null   // Path to CSV samplesheet (required)
params.outdir  = 'results'

// --- Imports ---
include { FASTQC } from './modules/nf-core/fastqc/main'

include { MULTIQC } from './modules/nf-core/multiqc/main'
// --- Workflow ---

workflow {

}

// --- Output ---
