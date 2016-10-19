; All Programs General 
<MSWord>: 
	CustomActions ( "<Wordleft>", "move to the left [Count] times") 
	CustomActions ( "<WordRight>", "move right [Count] times") 
	CustomActions ( "<WordUp> "" move up [Count] times ") 
	CustomActions (" <WordDown> "," move down [Count] times ") 
return 
<WordAdd>: 
	oWord: = ComObjCreate (" Word.Application ") 
	oWord.Documents.Add 
	oWord.Selection.TypeText ( "Line1`n") 
	oWord.Selection.TypeText ( "Line2`n") 
	oWord.Selection.TypeText ( "Line3`n") 
	oWord.Visible: = True 
return 
<WordLeft>: 
	oWord.Selection .previous (1,1) .Select 
return 
<WordRight>: 
	oWord.Selection.Next (1,1) .Select 
return 
<WordUp>: 
	oWord.Selection.MoveUp (5,1) 
return 
<WordDown>: 
	oWord.Selection. MoveDown (5,1) 
return
