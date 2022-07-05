unit cCadCategoria;

interface


uses System.Classes,
     Vcl.Controls,
     Vcl.ExtCtrls,
     Vcl.Dialogs,
     ZAbstractConnection,
     ZConnection, //Conex�es

     ZAbstractRODataset,
     ZAbstractDataset,
     ZDataset,
     System.SysUtils; //  LISTA DE UNITS


type
  TCategoria = class  // DECLARA��O DO TIPO DE CLASSE
  private
    ConexaoDB:TZConnection;
    F_CATEGORIASID:Integer;  //Int
    F_DESCRICAO:String;

    function getCodigo: Integer;
    function getDescricao: string;
    procedure setCodigo(const Value: Integer);
    procedure setDescricao(const Value: string); //VarChar

        //VARIAVEIS PRIVADA SOMENTE DENTRO DA CLASSE
  public
      constructor Create (aConexao:TZConnection); // CONSTRUTOR DA CLASSE
      destructor Destroy; override;  //DESTROI A CLASSE USAR O OVERRIDE POR CAUSA
                                     //DE SOBRESCREVER
      function Inserir:Boolean;
      function Atualizar:Boolean;
      function Apagar:Boolean;
      function Selecionar(id:Integer):Boolean;
        //VARIAVEIS PUBLICAS QUE PODE SER TRABALHADA FORA DA CLASSE
  published
    property codigo:Integer read getCodigo write setCodigo;
    property descricao:string read getDescricao write setDescricao;
      //VARIAVEIS PUBLICAS UTILIZADAS PARA PROPRIEDADES DA CLASSE
      //PARA FORNECER INFORMA��ES EM RUNTIME
  end;

implementation

{ TCategoria }

{$region 'CONSTRUCTOR AND DESTRUCTOR'}
constructor TCategoria.Create(aConexao:TZConnection);
begin
  ConexaoDB:=aConexao;
end;

destructor TCategoria.Destroy;
begin

  inherited;
end;
{$endregion}

{$region 'CRUD'}
function TCategoria.Apagar: Boolean;
var Qry:TZQuery;
begin
  if MessageDlg('Apagar o Registro: '+#13+#13+
                'C�digo: '+IntToStr(F_CATEGORIASID)+#13+
                'Descri��o: '+F_DESCRICAO,mtConfirmation,[mbYes, mbNo],0)=mrNo then begin
                  Result:=false;
                  Abort;
                end;
   try
     Result:=true;
     Qry:=TZQuery.Create(nil);
     Qry.Connection:=ConexaoDB;
     Qry.SQL.Clear;
     Qry.SQL.Add('DELETE FROM CATEGORIAS '+
                 ' WHERE CATEGORIASID=:CATEGORIASID ');
     Qry.ParamByName('CATEGORIASID').AsInteger :=F_CATEGORIASID;

     Try
      Qry.ExecSQL;
     Except
      Result:=false;
     End;

   finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
   end;
end;

function TCategoria.Atualizar: Boolean;
var Qry:TZQuery;
begin
  try
    Result:=true;
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add(' UPDATE CATEGORIAS '+
                ' SET   DESCRICAO    =:DESCRICAO '+
                ' WHERE CATEGORIASID =:CATEGORIASID ');
    Qry.ParamByName('CATEGORIASID').AsInteger :=Self.F_CATEGORIASID;
    Qry.ParamByName('descricao').AsString :=Self.F_DESCRICAO;

    Try
      Qry.ExecSQL;
    Except
      Result:=false;
    End;

  Finally
      if Assigned(Qry) then
      FreeAndNil (Qry);
  end;
end;

function TCategoria.Inserir: Boolean;
var Qry:TZQuery;
begin
  try
    Result:=true;
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO CATEGORIAS (DESCRICAO) values (:DESCRICAO)');
    Qry.ParamByName('DESCRICAO').AsString:=Self.F_DESCRICAO;
    try
      Qry.ExecSQL;
    Except
      Result:=false;
    end;

  finally
    if Assigned(Qry) then
      FreeAndNil (Qry);
  end;
end;

function TCategoria.Selecionar(id: Integer): Boolean;
var Qry:TZQuery;
begin
  try
    Result:=true;
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT CATEGORIASID,'+
                '       DESCRICAO '+
                ' FROM CATEGORIAS '+
                'WHERE CATEGORIASID=:CATEGORIASID');
    Qry.ParamByName('CATEGORIASID').AsInteger:=id;
    try
      Qry.Open;

      Self.F_CATEGORIASID:= Qry.FieldByName('CATEGORIASID').AsInteger;
      Self.F_DESCRICAO   := Qry.FieldByName('DESCRICAO').AsString;
    Except
      Result:=False;
    end;

  finally
    if Assigned(Qry) then
      FreeAndNil (Qry);
  end;
end;

{$endregion}

{$region 'GETS'}
function TCategoria.getCodigo: Integer;
begin
  Result := Self.F_CATEGORIASID;
end;

function TCategoria.getDescricao: string;
begin
  Result := Self.F_DESCRICAO;
end;
{$endregion}

{$region 'SETS'}
procedure TCategoria.setCodigo(const Value: Integer);
begin
  Self.F_CATEGORIASID := Value;
end;

procedure TCategoria.setDescricao(const Value: string);
begin
  Self.F_DESCRICAO := Value;
end;
{$endregion}

end.