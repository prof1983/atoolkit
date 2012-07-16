// 16.07.2012

#include <QPushButton>
#include "AUi"

APushButton
afunc APushButton_New(QString Text, AWidget Parent)
{
	return new QPushButton(Text, Parent);
}
