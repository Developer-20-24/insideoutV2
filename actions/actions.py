from typing import Any, Text, Dict, List
from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
import re


class ActionValidateInput(Action):
    def name(self) -> Text:
        return "action_validate_input"


    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
           
        user_message = tracker.latest_message.get('text', '')
       
        if re.search(r'\d', user_message):
            dispatcher.utter_message(text="Lo siento, no puedo procesar números ni secuencias numéricas. Por favor, hazme una pregunta sobre nuestros servicios usando palabras.")
            return []
           
        return []
