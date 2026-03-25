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


// --- Channel factory: parse CSV ---

// Expected CSV columns: sample,fastq_1,fastq_2
// For single-end reads, leave fastq_2 empty.
def create_fastq_channel(samplesheet) {
    channel
        .fromPath(samplesheet, checkIfExists: true)
        .splitCsv(header: true, strip: true)
        .map { row ->
            def meta = [id: row.sample]
            def reads = row.fastq_2
                ? [file(row.fastq_1, checkIfExists: true),
                   file(row.fastq_2, checkIfExists: true)]
                : [file(row.fastq_1, checkIfExists: true)]
            [meta, reads]
        }
}

// --- Workflow ---

workflow FASTQC_MULTIQC {
    take:
        ch_reads

    main:
        

        // 2. Run FASTQC on every sample
        FASTQC(ch_reads)

        // 3. Collect all FASTQC reports and run MULTIQC
        ch_multiqc_files = FASTQC.out.zip.collect{ it[1] }
                        .map{ files -> [ [id: 'multiqc'], files ] }

        MULTIQC(
            ch_multiqc_files.combine( channel.value([ [], [], [], [] ]) )
        )
    emit:
        html = FASTQC.out.html
        report = MULTIQC.out.report


}

workflow {
    main:
        // 1. Build the reads channel from the samplesheet
        ch_reads = create_fastq_channel(params.input)
        FASTQC_MULTIQC(ch_reads)

    publish:
        fastqc_html = FASTQC_MULTIQC.out.html
        multiqc_report = FASTQC_MULTIQC.out.report
}

// ── Output block: new-style publish directives ──────────────────────
output {
    fastqc_html {
        path 'fastqc'
    }

    multiqc_report {
        path 'multiqc'
    }
}