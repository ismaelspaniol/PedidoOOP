unit uClientes;

interface

type
  TCliente = Class
  private
    Fuf: String;
    Fcodigo: Integer;
    Fnome: String;
    Fcidade: string;
    procedure Setcidade(const Value: string);
    procedure Setcodigo(const Value: Integer);
    procedure Setnome(const Value: String);
    procedure Setuf(const Value: String);

  public
    property codigo: Integer read Fcodigo write Setcodigo;
    property nome: String read Fnome write Setnome;
    property cidade: string read Fcidade write Setcidade;
    property uf: String read Fuf write Setuf;
  End;

implementation

{ TClientes }

procedure TCliente.Setcidade(const Value: string);
begin
  Fcidade := Value;
end;

procedure TCliente.Setcodigo(const Value: Integer);
begin
  Fcodigo := Value;
end;

procedure TCliente.Setnome(const Value: String);
begin
  Fnome := Value;
end;

procedure TCliente.Setuf(const Value: String);
begin
  Fuf := Value;
end;

end.
