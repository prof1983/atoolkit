﻿{**
@Abstract Документ. Реализация интерфейса IProfDocument
@Author Prof1983 <prof1983@ya.ru>
@Created 11.04.2007
@LastMod 23.11.2012
}
unit ADocumentImpl;

interface

uses
  ABase, ADocumentIntf, AEntityImpl;

type //** Документ. Реализация интерфейса IProfDocument
  TProfDocument = class(TANamedEntity, IProfDocument)
  private
    FIsOpened: WordBool;
  protected
    {**
      Открыт ли документ?
      Реализация метода IsOpened должна проверить соответствующие свойства
      Объекта для определения состояния документа.
    }
    function GetIsOpened(): WordBool; safecall;
  public
    {**
      Закрыть документ
      Реализация метода Close() должна содержать действия по нейтрализации
      результатов работы метода Open().
    }
    procedure CloseDocument(); safecall;
    {**
      Открыть документ
      Реализация метода Open() должна содержать все необходимые действия для
      обеспечения корректной и безошибочной работы других методов документа.
      Этот метод запускается первым после создания экземпляра класса.
      @returns(Возврашает 0 в случае успешного выполнения;
        положительное число, если есть замечания;
        отрицательное число, если есть ошибки (открыть документ не удалось))
    }
    function OpenDocument(): AError; safecall;
  public
    {**
      Открыт ли документ?
      Реализация IsOpened должна проверить соответствующие свойства Объекта
      для определения состояния документа.
    }
    property IsOpened: WordBool read GetIsOpened;
  end;

implementation

{ TProfDocument }

procedure TProfDocument.CloseDocument();
begin
  FIsOpened := False;
end;

function TProfDocument.GetIsOpened(): WordBool;
begin
  Result := FIsOpened;
end;

function TProfDocument.OpenDocument(): AError;
begin
  FIsOpened := True;
end;

end.
