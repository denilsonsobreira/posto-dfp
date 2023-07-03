unit uAbastecimento;

interface

uses
  System.SysUtils, uBomba;

type
  TAbastecimento = class
    private
      FBomba: TBomba;
      FId: Integer;
      FValorTotal: Currency;
      FLitros: Currency;
      FData: TDateTime;
      FImposto: Currency;
      procedure SetBomba(const Value: TBomba);
      procedure SetData(const Value: TDateTime);
      procedure SetId(const Value: Integer);
      procedure SetImposto(const Value: Currency);
      procedure SetLitros(const Value: Currency);
      procedure SetValorTotal(const Value: Currency);
    public
      property Id: Integer read FId write SetId;
      property Litros: Currency read FLitros write SetLitros;
      property Imposto: Currency read FImposto write SetImposto;
      property ValorTotal: Currency read FValorTotal write SetValorTotal;
      property Data: TDateTime read FData write SetData;
      property Bomba: TBomba read FBomba write SetBomba;
  end;

implementation

{ TAbastecimento }

procedure TAbastecimento.SetBomba(const Value: TBomba);
begin
  FBomba := Value;
end;

procedure TAbastecimento.SetData(const Value: TDateTime);
begin
  FData := Value;
end;

procedure TAbastecimento.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TAbastecimento.SetImposto(const Value: Currency);
begin
  FImposto := Value;
end;

procedure TAbastecimento.SetLitros(const Value: Currency);
begin
  FLitros := Value;
end;

procedure TAbastecimento.SetValorTotal(const Value: Currency);
begin
  FValorTotal := Value;
end;

end.
