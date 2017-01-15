
&НаСервере
Функция СоздатьФайлДляПросмотраНаСервере(лИмяФайлаПолучитьИмяВременногоФайла)
	
	лКартинка = Справочники.Б_ХарактеристикиНоменклатурыПрисоединенныеФайлы.ПолучитьКартинкуПоПрикрепленномуФайлу(Объект.Ссылка);
	
	Если лКартинка <> Неопределено тогда
		
		лКартинка.Записать(лИмяФайлаПолучитьИмяВременногоФайла);
				
		Возврат Истина;
	
	Иначе
		
		Возврат Ложь;
		
	КонецЕсли;
	
КонецФункции

&НаКлиенте
Процедура ОткрытьФайлДляПросмотра(Команда)
	
	лИмяФайлаПолучитьИмяВременногоФайла = ПолучитьИмяВременногоФайла() + Объект.Расширение;

	Если СоздатьФайлДляПросмотраНаСервере(лИмяФайлаПолучитьИмяВременногоФайла) = Истина тогда
			
		ЗапуститьПриложение(лИмяФайлаПолучитьИмяВременногоФайла);
		
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ОбновитьИзФайлаНаДиске(Команда)
		
	Если Не ПодключитьРасширениеРаботыСФайлами() Тогда
		Предупреждение(НСтр("ru = 'Для данной операции необходимо установить расширение работы с файлами!'"));
		Возврат;
	КонецЕсли;
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	Диалог.Заголовок = НСтр("ru = 'Укажите файл/картинку'");
	
	Если Диалог.Выбрать() Тогда
		
		лИмяФайла = Диалог.ПолноеИмяФайла; 
		
		лФайл = Новый Файл(лИмяФайла);
																										
		Объект.ПутьКФайлу 	= лИмяФайла;
		Объект.Расширение 	= лФайл.Расширение;
		Объект.Размер 		= лФайл.Размер();
		
		ПараметрыФайла = Новый Структура;
		ПараметрыФайла.Вставить("ПрисоединенныйФайл", Объект.Ссылка);	
		ПараметрыФайла.Вставить("ИмяФайла"			, лИмяФайла);	
		
		ЗаписатьПрисоединенныйФайл(ПараметрыФайла);
	
	КонецЕсли;


КонецПроцедуры

&НаСервере
Процедура ЗаписатьПрисоединенныйФайл(ПараметрыФайла)
	
	Справочники.Б_ХарактеристикиНоменклатурыПрисоединенныеФайлы.ЗаписатьПрисоединенныйФайл(ПараметрыФайла);
	
КонецПроцедуры

&НаКлиенте
Процедура Основная(Команда)
	Объект.Основная = НЕ Объект.Основная;
	Элементы.ФормаОсновная.Пометка = Объект.Основная;
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Элементы.ФормаОсновная.Пометка = Объект.Основная;
КонецПроцедуры


