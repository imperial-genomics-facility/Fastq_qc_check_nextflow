#!/usr/bin/env nextflow

/*
* QC Pipeline
*/

nextflow.enable.dsl=2

// --- Parameters ---

// --- Imports ---
include { FASTQC } from './modules/nf-core/fastqc/main'

include { MULTIQC } from '../modules/nf-core/multiqc/main'  
// --- Workflow ---

workflow {

}

// --- Output ---
