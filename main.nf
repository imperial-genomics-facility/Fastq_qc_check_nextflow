#!/usr/bin/env nextflow

/*
* QC Pipeline
*/

nextflow.enable.dsl=2

// --- Parameters ---

// --- Imports ---
include { FASTQC } from './modules/nf-core/fastqc/main'
// --- Workflow ---

workflow {

}

// --- Output ---
