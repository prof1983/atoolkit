{**
@Abstract(Модуль работы с XVRML и OpenGL)
@Author(Prof1983 prof1983@ya.ru)
@Created(14.03.2007)
@LastMod(27.04.2012)
@Version(0.5)
}
unit AXVrmlOpenGl;

interface

uses
  OpenGl,
  AXVrml, ANodeIntf;

type
  TPointArray = array of TGLArrayf3;

procedure PaintPolygon(const AValue: TXVrmlString);
procedure PaintPolygonA(A: TPointArray);
procedure PaintPolygonX(ANode: IProfNode);

implementation

procedure PaintPolygonA(A: TPointArray);
var
  i: Integer;
begin
  // Начинаем отрисовку полигона
  glBegin(GL_POLYGON);
  // Задаем начальную точку полигона
  glNormal3f(0.0, 0.0, -1.0);
  // Задаем точки полигона
  for i := 0 to High(A) do
    glVertex3f(A[i, 0], A[i, 1], A[i, 2]);
  // Завершаем отрисовку
  glEnd();
end;

procedure PaintPolygonX(ANode: IProfNode);
//var
//  i: Integer;
//  node: IProfNode;
begin
{
  // Начинаем отрисовку полигона
  glBegin(GL_POLYGON);
  // Задаем начальную точку полигона
  glNormal3f(0.0, 0.0, -1.0);
  // Задаем точки полигона
  for i := 0 to ANode.ChildNodes.NodeCount - 1 do
  begin
    node := ANode.ChildNodes.NodeByIndex[i];
    if Assigned(node) then
    begin
      glVertex3f(node.ReadFloat64Def('x', 0),
                 node.ReadFloat64Def('y', 0),
                 node.ReadFloat64Def('z', 0));
    end;
  end;
  // Завершаем отрисовку
  glEnd();
}
end;

procedure PaintPolygon(const AValue: TXVrmlString);
begin
    glBegin(GL_POLYGON);
    glNormal3f(0.0, 0.0, -1.0);

    glVertex3f(-0.26, 0.14,0);
    glVertex3f(-1, 1,0);
    glVertex3f(0, 0.44,0);
    glVertex3f(1, 1,0);
    glVertex3f(0.26, 0.14,0);
    glVertex3f(1, 0,0);
    glVertex3f(0.22, -0.18,0);
    glVertex3f(0, -1,0);
    glVertex3f(-0.22, -0.18,0);
    glVertex3f(-1, 0,0);
    glEnd();
end;

end.
