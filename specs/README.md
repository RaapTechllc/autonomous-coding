## Specs

This folder is for **your versioned MVP specs**.

- Put one spec per MVP (for example: `specs/invoice_mvp.txt`).
- Start a new run with:

```bash
python autonomous_agent_demo.py --project-dir invoice_mvp --spec specs/invoice_mvp.txt
```

On first run, the harness copies your spec into the generated project as `app_spec.txt`.
After that, editing the spec in `specs/` won’t change an in-progress MVP unless you update the generated project’s `app_spec.txt` too.
