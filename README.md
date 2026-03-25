# Fastq_qc_check_nextflow

A Nextflow pipeline for running comprehensive QC (Quality Control) checks on FASTQ files. This pipeline automates quality assessment using FastQC and provides aggregated reports through MultiQC, making it easy to evaluate large batches of sequencing data.

## Overview

This pipeline streamlines the quality control process for Next-Generation Sequencing (NGS) data by:
- Performing individual FASTQ file analysis with FastQC
- Generating aggregated quality reports with MultiQC
- Providing configurable parameters for flexible workflows
- Enabling reproducible quality assessments

## Features

- ✅ Automated FastQC analysis for individual FASTQ files
- ✅ Aggregated MultiQC reports for comprehensive batch analysis
- ✅ Highly configurable parameters for custom workflows
- ✅ Support for both single-end and paired-end sequencing data
- ✅ Containerized execution with Docker/Singularity support
- ✅ Efficient parallel processing with Nextflow

## Prerequisites

Before running this pipeline, ensure you have the following installed:

- **Nextflow** (v20.10 or higher)
- **Java** (version 11 or higher)
- **Docker** or **Singularity** (for containerized execution, optional but recommended)
- **FastQC** (will be installed automatically if using containers)
- **MultiQC** (will be installed automatically if using containers)

## Installation

### Clone the repository

```bash
git clone https://github.com/imperial-genomics-facility/Fastq_qc_check_nextflow.git
cd Fastq_qc_check_nextflow
```

### Install Nextflow (if not already installed)

```bash
curl -s https://get.nextflow.io | bash
chmod +x nextflow
```

## Usage

### Basic Usage

```bash
nextflow run main.nf --input_dir <path_to_fastq_files> --output_dir <output_directory>
```

### Example Commands

```bash
# Run on local machine
nextflow run main.nf --input_dir ./fastq_data --output_dir ./results

# Run with Docker
nextflow run main.nf --input_dir ./fastq_data --output_dir ./results -profile docker

# Run with Singularity
nextflow run main.nf --input_dir ./fastq_data --output_dir ./results -profile singularity
```

## Parameters

| Parameter | Description | Default | Type |
|-----------|-------------|---------|------|
| `input_dir` | Directory containing FASTQ files | `.` | String |
| `output_dir` | Directory for results output | `./results` | String |
| `threads` | Number of threads per process | `4` | Integer |
| `extension` | FASTQ file extension | `*.fastq` | String |

### Advanced Parameters

You can also pass parameters via a config file:

```bash
nextflow run main.nf -c custom.config --input_dir ./fastq_data
```

## Workflow

The pipeline follows these main steps:

1. **Input Validation** - Scans the input directory for FASTQ files
2. **FastQC Analysis** - Runs FastQC on each individual FASTQ file
3. **MultiQC Aggregation** - Generates a comprehensive quality report combining all FastQC results
4. **Report Generation** - Produces HTML reports for easy visualization

## Output

The pipeline generates the following outputs in the specified `output_dir`:

```
results/
├── fastqc/
│   ├── sample1_fastqc.html
│   ├── sample1_fastqc.zip
│   ├── sample2_fastqc.html
│   ├── sample2_fastqc.zip
│   └── ...
├── multiqc_report.html          # Main aggregated quality report
└── multiqc_data/
    ├── multiqc_general_stats.txt
    ├── multiqc_data.json
    └── ...
```

### Output Files Explanation

- **FastQC HTML Reports** - Individual quality reports for each FASTQ file with detailed metrics
- **FastQC ZIP Files** - Raw FastQC data and plots
- **MultiQC Report** - Comprehensive HTML summary comparing all samples
- **MultiQC Data** - JSON and tabular data for further analysis

## Pipeline Monitoring

To monitor your pipeline execution:

```bash
# View real-time progress
nextflow run main.nf ... -with-trace trace.txt

# Generate HTML execution report
nextflow run main.nf ... -with-report report.html

# View execution timeline
nextflow run main.nf ... -with-timeline timeline.html
```

## Troubleshooting

### Issue: "FASTQ files not found"

**Solution:** Verify the input directory path and ensure FASTQ files have the correct extension:

```bash
ls -la /path/to/fastq_files/
```

### Issue: "Memory allocation error"

**Solution:** Increase memory allocation:

```bash
nextflow run main.nf --max_memory '32.GB' --max_cpus 8
```

### Issue: "Docker/Singularity not available"

**Solution:** Run without containers (ensure tools are installed locally):

```bash
nextflow run main.nf --input_dir ./fastq_data -profile local
```

## Configuration Profiles

The pipeline includes several predefined profiles:

- `local` - Run on local machine (requires tools to be installed)
- `docker` - Use Docker containers
- `singularity` - Use Singularity containers
- `slurm` - Run on SLURM cluster
- `lsf` - Run on LSF cluster

## Dependencies

This pipeline automatically manages the following tools (when using containers):

- **FastQC** - Quality assessment tool for high throughput sequencing data
- **MultiQC** - Aggregates analysis results across many samples

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Commit your changes (`git commit -am 'Add improvement'`)
4. Push to the branch (`git push origin feature/improvement`)
5. Open a Pull Request

## Authors

- Jess (FastQC integration)
- Hamza (MultiQC integration and documentation)

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues, questions, or suggestions:

1. **Check existing issues** - Search the [GitHub issues](https://github.com/imperial-genomics-facility/Fastq_qc_check_nextflow/issues)
2. **Open a new issue** - Provide details about your problem and expected behavior
3. **Contact the maintainers** - Reach out to the development team

## Citation

If you use this pipeline in your research, please cite:

```
Fastq_qc_check_nextflow - A Nextflow pipeline for FASTQ quality control
Imperial College London Genomics Facility
https://github.com/imperial-genomics-facility/Fastq_qc_check_nextflow
```

## References

- [Nextflow Documentation](https://www.nextflow.io/docs/latest/index.html)
- [FastQC Documentation](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
- [MultiQC Documentation](https://multiqc.info/)