#!/usr/bin/env python3

import sys
from pathlib import Path
from datetime import datetime

if len(sys.argv) < 3:
    print("Usage: python3 prompt_report.py <log-file> <prompt>")
    sys.exit(1)

log_file = Path(sys.argv[1])
prompt = sys.argv[2]

if not log_file.exists():
    print(f"ERROR: Log file not found: {log_file}")
    sys.exit(1)

content = log_file.read_text(errors="ignore")

error_keywords = [
    "error",
    "failed",
    "failure",
    "command not found",
    "permission denied",
    "fatal"
]

errors = []

for line in content.splitlines():
    if any(keyword in line.lower() for keyword in error_keywords):
        errors.append(line)

status = "SUCCESS" if not errors else "FAILURE"

report = []

report.append("# Automation Analysis Report")
report.append("")
report.append(f"Generated: {datetime.now()}")
report.append("")
report.append("## Prompt")
report.append(prompt)
report.append("")
report.append("## Pipeline Status")
report.append(status)
report.append("")
report.append("## Log Statistics")
report.append(f"Total lines: {len(content.splitlines())}")
report.append(f"Detected errors: {len(errors)}")
report.append("")

if errors:
    report.append("## Detected Problems")
    for error in errors[:20]:
        report.append(f"- {error}")

    report.append("")
    report.append("## Recommended Actions")
    report.append("- Inspect the failed command.")
    report.append("- Check file paths and permissions.")
    report.append("- Check cron/systemd logs.")
    report.append("- Correct the problem and rerun the pipeline.")
else:
    report.append("## Analysis")
    report.append("No major errors were detected.")
    report.append("")
    report.append("## Recommended Actions")
    report.append("- Continue monitoring scheduled executions.")
    report.append("- Verify generated reports.")
    report.append("- Verify Git synchronization.")

Path("automation-summary.md").write_text("\n".join(report))

print("\n".join(report))

