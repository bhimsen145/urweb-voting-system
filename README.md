# Ur/Web Voting System

A type-safe online voting system built in Ur/Web, demonstrating how the 
language eliminates SQL Injection, XSS, and CSRF by compiler design.

## Files

| File | Purpose |
|------|---------|
| `voting.ur` | Main application logic |
| `voting.urs` | Module signature (public interface) |
| `voting.urp` | Project configuration file |
| `voting.sql` | SQLite database schema |
| `style.css` | User interface styling |

## Requirements

- Ur/Web compiler — http://www.impredicative.com/ur/
- SQLite3
- nginx (to serve static CSS)

## Build and Run

```bash
# Step 1 — Compile
urweb -dbms sqlite voting

# Step 2 — Create database
sqlite3 voting.db < voting.sql

# Step 3 — Start nginx
sudo systemctl start nginx

# Step 4 — Run the server
./voting.exe

# Step 5 — Open in browser
http://localhost/
```

## Security Guarantees

| Vulnerability | Status | Mechanism |
|--------------|--------|-----------|
| SQL Injection | ✅ Eliminated | Typed {[value]} placeholder |
| Stored XSS | ✅ Eliminated | Auto htmlifyString() via {[...]} |
| CSRF | ✅ Eliminated | Auto uw_nonce on every form |
| Unlimited Voting | ⚠️ Dev logic needed | Add IP tracking table |
