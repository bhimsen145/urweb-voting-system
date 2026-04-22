style container
style candidate
style result_btn

table candidates : { Id : int, Name : string, Votes : int }
  PRIMARY KEY Id

fun castVote (r : {Candidate : string}) =
    let
        val candId = readError r.Candidate : int
    in
        dml (UPDATE candidates SET Votes = Votes + 1 WHERE Id = {[candId]});
        return <xml>
            <head>
                <title>Success</title>
                <link rel="stylesheet" type="text/css" href="/style.css"/>
            </head>
            <body>
                <div class={container}>
                    <h2>✅ Vote Recorded!</h2>
                    <p>Thank you for voting.</p>
                    <a link={main ()}><button>Back</button></a>
                </div>
            </body>
        </xml>
    end

and results () =
    rows <- queryX1 (SELECT * FROM candidates ORDER BY candidates.Votes DESC)
            (fn row => <xml>
                <p>🏆 <strong>{[row.Name]}</strong> — {[row.Votes]} votes</p>
            </xml>);
    return <xml>
        <head>
            <title>Results</title>
            <link rel="stylesheet" type="text/css" href="/style.css"/>
        </head>
        <body>
            <div class={container}>
                <h2>📊 Live Results</h2>
                {rows}
                <a link={main ()}><button>Back</button></a>
            </div>
        </body>
    </xml>

and main () =
    rows <- queryX1 (SELECT * FROM candidates)
             (fn row => <xml>
                <form>
                    <hidden{#Candidate} value={show row.Id}/>
                    <submit action={castVote} value={row.Name} class={candidate}/>
                </form>
             </xml>);
    return <xml>
        <head>
            <title>Voting System</title>
            <link rel="stylesheet" type="text/css" href="/style.css"/>
        </head>
        <body>
            <div class={container}>
                <h2>🗳️ Cast Your Vote</h2>
                {rows}
                <a link={results ()}>
                    <button class={result_btn}>View Results</button>
                </a>
            </div>
        </body>
    </xml>