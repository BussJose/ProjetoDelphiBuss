unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uDTMConexao, Enter;

type
  TfrmPrincipal = class(TForm)
    mainPrincipal: TMainMenu;
    Cadastro1: TMenuItem;
    Movimentao1: TMenuItem;
    Relatrios1: TMenuItem;
    Cliente1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Produto1: TMenuItem;
    N3: TMenuItem;
    menuFechar: TMenuItem;
    Vendas1: TMenuItem;
    Cliente2: TMenuItem;
    N4: TMenuItem;
    Produto2: TMenuItem;
    N5: TMenuItem;
    Vendaspordata1: TMenuItem;
    procedure menuFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    TeclaEnter: TMREnter;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uCadCategorias;

procedure TfrmPrincipal.N2Click(Sender: TObject);
begin
  frmCadCategoria:=TfrmCadCategoria.Create(Self);
  frmCadCategoria.ShowModal;
  frmCadCategoria.Release;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil (TeclaEnter);
  FreeAndNil (dtmPrincipal);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
   dtmPrincipal := TdtmPrincipal.Create (Self);
   with dtmPrincipal.ConexaoDB do
   begin
     SQLHourGlass:= False;
     Protocol := 'mssql';
     LibraryLocation:= 'C:\ProjetoDelphi\ntwdblib.dll';
     HostName:= '.\SERVERBUSS';
     Port:= 1433;
     User:= 'sa';
     Password:= '59912020';
     Database:= 'VENDAS';
     Connected:= True;
   end;

   TeclaEnter:= TMREnter.Create(Self);
   TeclaEnter.FocusEnabled:= True;
   TeclaEnter.FocusColor:=clInfoBK;
end;

procedure TfrmPrincipal.menuFecharClick(Sender: TObject);
begin
  //Close;
  Application.Terminate;
end;

end.
