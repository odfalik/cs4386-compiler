# Example-Project
Stmt          →	Decl
              |	Asn
              |	ReadVar
              |	PrintVar

Decl          →	var id OptionalAsn ;

Asn		      →	id = Expr ;

ReadVar	      →	read id ;

PrintVar 	  →	print id ;

OptionalAsn	  →	= Expr
              |	λ

Expr		  →	Expr BinaryOp Expr
              |	intlit
              |	id

Binaryop	  →	* 
              |	/ 
              |	+ 
              | -

------------------------------------------------------

Program             → class id { Memberdecls }
Memberdecls         → Fielddecls Methoddecls
Fielddecls          → Fielddecl Fielddecls | λ
Methoddecls         → Methoddecl Methoddecls | λ
Fielddecl           → Optionalfinal Type id Optionalexpr ;
                    | Type id [ intlit ] ;
Optionalfinal       → final | λ
Optionalexpr        → = Expr | λ
Methoddecl          → Returntype id ( Argdecls ) { Fielddecls Stmts } Optionalsemi
Optionalsemi        → ; | λ
Returntype          → Type | void
Type                → int | char | bool | float
Argdecls            → ArgdeclList | λ
ArgdeclList         → Argdecl , ArgdeclList | Argdecl
Argdecl             → Type id | Type id [ ]
Stmts               → Stmt Stmts | λ
Stmt                → if ( Expr ) Stmt OptionalElse | while ( Expr ) Stmt | Name = Expr ;
                    | read ( Readlist ) ; | print ( Printlist ) ; | printline ( Printlinelist ) ;
                    | id ( ) ; | id ( Args ) ; | return ; | return Expr ; | Name ++ | Name --
                    | { Fielddecls Stmts } Optionalsemi
OptionalElse        → else Stmt | λ
Name                → id | id [ Expr ]
Args                → Expr , Args | Expr
Readlist            → Name , Readlist | Name
Printlist           → Expr , Printlist | Expr
Printlinelist       → Printlist | λ
Expr                → Name | id ( ) | id ( Args ) | intlit | charlit | strlit | floatlit | true | false
                    | ( Expr ) | ~ Expr | - Expr | + Expr | ( Type ) Expr |
                    | Expr Binaryop Expr | ( Expr ? Expr : Expr )
Binaryop            → * | / | + | - | < | > | <= | >= | == | <> | \|\| | &&