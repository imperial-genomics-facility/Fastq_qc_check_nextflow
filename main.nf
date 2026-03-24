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

    // 1. Build the reads channel from the samplesheet
    ch_reads = create_fastq_channel(params.input)

    // 2. Run FASTQC on every sample
    FASTQC(ch_reads)

    // 3. Collect all FASTQC reports and run MULTIQC
    MULTIQC(
        FASTQC.out.zip.collect{ it[1] },   // strip meta, collect all zips
        [],                                  // multiqc_config
        [],                                  // extra_multiqc_config
        [],                                  // multiqc_logo
        [],                                  // replace_names
        []                                   // sample_names
    )

    // 4. Expose outputs for the publish directive
    publish:
    FASTQC.out.html  >> 'fastqc'
    FASTQC.out.zip   >> 'fastqc'
    MULTIQC.out.report >> 'multiqc'
}

// ── Output block: new-style publish directives ──────────────────────
output {
    directory params.outdir
    mode 'copy'

    'fastqc' {
        path 'fastqc'
    }

    'multiqc' {
        path 'multiqc'
    }
}

// --- Output ---
output {
    directory params.outdir
    mode 'copy'

    'fastqc' {
        path 'fastqc'
    }

    'multiqc' {
        path 'multiqc'
    }
}