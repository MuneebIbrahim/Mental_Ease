import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class questions extends StatefulWidget{
  @override
  State<questions> createState() => questionsState();
}

class questionsState extends State<questions>{
  int currentQuestionIndex = 0;
  TextEditingController _textController = TextEditingController();
  String? lastInputValue;
  int? lastQuestionIndex;

  List<Map<String,dynamic>> questionsList = [
    // {
    //   'question': 'I found myself getting upset by quite trivial things.',
    //   'options' : ['Did not apply to me at all','Applied to me to some degree, or some of the time',
    //             'Applied to me to a considerable degree, or a good part of the time','Applied to me very much, or most of the time']
    // },
    // {
    //   'question' : 'I was aware of dryness of my mouth.',
    //   'options' : ['Did not apply to me at all','Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time','Applied to me very much, or most of the time']
    // },
    // {
    //   'question' : 'I could not seem to experience any positive feeling at all.',
    //   'options' : ['Did not apply to me at all','Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time','Applied to me very much, or most of the time']
    // },
    // {
    //   'question' : 'I experienced breathing difficulty (eg, excessively rapid breathing,)',
    //   'options' : ['Did not apply to me at all','Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time','Applied to me very much, or most of the time']
    // },
    // {
    //   'question' : 'I just couldn&#39;t seem to get going.',
    //   'options' : ['Did not apply to me at all','Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time','Applied to me very much, or most of the time']
    // },
    // {
    //   'question' : 'I tended to over-react to situations.',
    //   'options' : ['Did not apply to me at all','Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time','Applied to me very much, or most of the time']
    // },
    // {
    //   'question' : 'I had a feeling of shakiness (eg, legs going to give way).',
    //   'options' : ['Did not apply to me at all','Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time','Applied to me very much, or most of the time']
    // },
    // {
    //   'question' : 'I found it difficult to relax.',
    //   'options' : ['Did not apply to me at all','Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time','Applied to me very much, or most of the time']
    // },
    // {
    //   'question' : 'I found myself in situations that made me so anxious I was most relieved when they ended.',
    //   'options' : ['Did not apply to me at all','Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time','Applied to me very much, or most of the time']
    // },
    // {
    //   'question' : 'I felt that I had nothing to look forward to.',
    //   'options' : ['Did not apply to me at all','Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time','Applied to me very much, or most of the time']
    // },
    // {
    //   'question' : 'I found myself getting upset rather easily.',
    //   'options' : ['Did not apply to me at all','Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time','Applied to me very much, or most of the time']
    // },
    // {
    //   'question' : 'I felt that I was using a lot of nervous energy.',
    //   'options' : ['Did not apply to me at all','Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time','Applied to me very much, or most of the time']
    // },
    // {
    //   'question' : 'I felt sad and depressed.',
    //   'options' : ['Did not apply to me at all','Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time','Applied to me very much, or most of the time']
    // },
    // {
    //   'question' : 'I found myself getting impatient when I was delayed in any way (eg, elevators, traffic lights)',
    //   'options' : ['Did not apply to me at all','Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time','Applied to me very much, or most of the time']
    // },
    // {
    //   'question' : 'I had a feeling of faintness.',
    //   'options' : ['Did not apply to me at all','Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time','Applied to me very much, or most of the time']
    // },
    // {
    //   'question': 'I felt that I had lost interest in just about everything.',
    //   'options': [
    //     'Did not apply to me at all',
    //     'Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time',
    //     'Applied to me very much, or most of the time'
    //   ],
    // },
    // {
    //   'question': "I felt I wasn't worth much as a person.",
    //   'options': [
    //     'Did not apply to me at all',
    //     'Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time',
    //     'Applied to me very much, or most of the time'
    //   ],
    // },
    // {
    //   'question': 'I felt that I was rather touchy.',
    //   'options': [
    //     'Did not apply to me at all',
    //     'Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time',
    //     'Applied to me very much, or most of the time'
    //   ],
    // },
    // {
    //   'question': 'I perspired noticeably in the absence of high temperatures or physical exertion.',
    //   'options': [
    //     'Did not apply to me at all',
    //     'Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time',
    //     'Applied to me very much, or most of the time'
    //   ],
    // },
    // {
    //   'question': 'I felt scared without any good reason.',
    //   'options': [
    //     'Did not apply to me at all',
    //     'Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time',
    //     'Applied to me very much, or most of the time'
    //   ],
    // },
    // {
    //   'question': "I felt that life wasn't worthwhile.",
    //   'options': [
    //     'Did not apply to me at all',
    //     'Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time',
    //     'Applied to me very much, or most of the time'
    //   ],
    // },
    // {
    //   'question': 'I found it hard to wind down.',
    //   'options': [
    //     'Did not apply to me at all',
    //     'Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time',
    //     'Applied to me very much, or most of the time'
    //   ],
    // },
    // {
    //   'question': 'I had difficulty in swallowing.',
    //   'options': [
    //     'Did not apply to me at all',
    //     'Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time',
    //     'Applied to me very much, or most of the time'
    //   ],
    // },
    // {
    //   'question': "I couldn't seem to get any enjoyment out of the things I did.",
    //   'options': [
    //     'Did not apply to me at all',
    //     'Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time',
    //     'Applied to me very much, or most of the time'
    //   ],
    // },
    // {
    //   'question': 'I was aware of the action of my heart in the absence of physical exertion .',
    //   'options': [
    //     'Did not apply to me at all',
    //     'Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time',
    //     'Applied to me very much, or most of the time'
    //   ],
    // },
    // {
    //   'question': 'I felt down-hearted and blue.',
    //   'options': [
    //     'Did not apply to me at all',
    //     'Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time',
    //     'Applied to me very much, or most of the time'
    //   ],
    // },
    // {
    //   'question': 'I found that I was very irritable.',
    //   'options': [
    //     'Did not apply to me at all',
    //     'Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time',
    //     'Applied to me very much, or most of the time'
    //   ],
    // },
    // {
    //   'question': 'I felt I was close to panic.',
    //   'options': [
    //     'Did not apply to me at all',
    //     'Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time',
    //     'Applied to me very much, or most of the time'
    //   ],
    // },
    // {
    //   'question': 'I found it hard to calm down after something upset me.',
    //   'options': [
    //     'Did not apply to me at all',
    //     'Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time',
    //     'Applied to me very much, or most of the time'
    //   ],
    // },
    // {
    //   'question': 'I feared that I would be "thrown" by some trivial but unfamiliar task.',
    //   'options': [
    //     'Did not apply to me at all',
    //     'Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time',
    //     'Applied to me very much, or most of the time'
    //   ],
    // },
    // {
    //   'question': 'I was unable to become enthusiastic about anything.',
    //   'options': [
    //     'Did not apply to me at all',
    //     'Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time',
    //     'Applied to me very much, or most of the time'
    //   ],
    // },
    // {
    //   'question': 'I found it difficult to tolerate interruptions to what I was doing.',
    //   'options': [
    //     'Did not apply to me at all',
    //     'Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time',
    //     'Applied to me very much, or most of the time'
    //   ],
    // },
    // {
    //   'question': 'I was in a state of nervous tension.',
    //   'options': [
    //     'Did not apply to me at all',
    //     'Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time',
    //     'Applied to me very much, or most of the time'
    //   ],
    // },
    // {
    //   'question': 'I felt I was pretty worthless.',
    //   'options': [
    //     'Did not apply to me at all',
    //     'Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time',
    //     'Applied to me very much, or most of the time'
    //   ],
    // },
    // {
    //   'question': 'I was intolerant of anything that kept me from getting on with what I was doing.',
    //   'options': [
    //     'Did not apply to me at all',
    //     'Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time',
    //     'Applied to me very much, or most of the time'
    //   ],
    // },
    // {
    //   'question': 'I felt terrified.',
    //   'options': [
    //     'Did not apply to me at all',
    //     'Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time',
    //     'Applied to me very much, or most of the time'
    //   ],
    // },
    // {
    //   'question': 'I could see nothing in the future to be hopeful about.',
    //   'options': [
    //     'Did not apply to me at all',
    //     'Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time',
    //     'Applied to me very much, or most of the time'
    //   ],
    // },
    // {
    //   'question': 'I felt that life was meaningless.',
    //   'options': [
    //     'Did not apply to me at all',
    //     'Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time',
    //     'Applied to me very much, or most of the time'
    //   ],
    // },
    // {
    //   'question': 'I found myself getting agitated.',
    //   'options': [
    //     'Did not apply to me at all',
    //     'Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time',
    //     'Applied to me very much, or most of the time'
    //   ],
    // },
    // {
    //   'question': 'I was worried about situations in which I might panic and make a fool of myself.',
    //   'options': [
    //     'Did not apply to me at all',
    //     'Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time',
    //     'Applied to me very much, or most of the time'
    //   ],
    // },
    // {
    //   'question': 'I experienced trembling (eg, in the hands).',
    //   'options': [
    //     'Did not apply to me at all',
    //     'Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time',
    //     'Applied to me very much, or most of the time'
    //   ],
    // },
    // {
    //   'question': 'I found it difficult to work up the initiative to do things.',
    //   'options': [
    //     'Did not apply to me at all',
    //     'Applied to me to some degree, or some of the time',
    //     'Applied to me to a considerable degree, or a good part of the time',
    //     'Applied to me very much, or most of the time'
    //   ],
    // },
    // {
    //   'question' : 'Extraverted, enthusiastic.',
    //   'options': [
    //     'Disagree strongly',
    //     'Disagree moderately',
    //     'Disagree a little',
    //     'Neither agree nor disagree',
    //     'Agree a little',
    //     'Agree moderately',
    //     'Agree strongly',
    //   ]
    // },
    // {
    //   'question' : 'Extraverted, enthusiastic.',
    //   'options': [
    //     'Disagree strongly',
    //     'Disagree moderately',
    //     'Disagree a little',
    //     'Neither agree nor disagree',
    //     'Agree a little',
    //     'Agree moderately',
    //     'Agree strongly',
    //   ]
    // },
    // {
    //   'question' : 'Critical, quarrelsome.',
    //   'options': [
    //     'Disagree strongly',
    //     'Disagree moderately',
    //     'Disagree a little',
    //     'Neither agree nor disagree',
    //     'Agree a little',
    //     'Agree moderately',
    //     'Agree strongly',
    //   ]
    // },
    // {
    //   'question' : 'Dependable, self-disciplined.',
    //   'options': [
    //     'Disagree strongly',
    //     'Disagree moderately',
    //     'Disagree a little',
    //     'Neither agree nor disagree',
    //     'Agree a little',
    //     'Agree moderately',
    //     'Agree strongly',
    //   ]
    // },
    // {
    //   'question' : 'Anxious, easily upset.',
    //   'options': [
    //     'Disagree strongly',
    //     'Disagree moderately',
    //     'Disagree a little',
    //     'Neither agree nor disagree',
    //     'Agree a little',
    //     'Agree moderately',
    //     'Agree strongly',
    //   ]
    // },
    // {
    //   'question' : 'Open to new experiences, complex',
    //   'options': [
    //     'Disagree strongly',
    //     'Disagree moderately',
    //     'Disagree a little',
    //     'Neither agree nor disagree',
    //     'Agree a little',
    //     'Agree moderately',
    //     'Agree strongly',
    //   ]
    // },
    // {
    //   'question' : 'Reserved, quiet.',
    //   'options': [
    //     'Disagree strongly',
    //     'Disagree moderately',
    //     'Disagree a little',
    //     'Neither agree nor disagree',
    //     'Agree a little',
    //     'Agree moderately',
    //     'Agree strongly',
    //   ]
    // },
    // {
    //   'question' : 'Sympathetic, warm.',
    //   'options': [
    //     'Disagree strongly',
    //     'Disagree moderately',
    //     'Disagree a little',
    //     'Neither agree nor disagree',
    //     'Agree a little',
    //     'Agree moderately',
    //     'Agree strongly',
    //   ]
    // },
    // {
    //   'question' : 'Disorganized, careless.',
    //   'options': [
    //     'Disagree strongly',
    //     'Disagree moderately',
    //     'Disagree a little',
    //     'Neither agree nor disagree',
    //     'Agree a little',
    //     'Agree moderately',
    //     'Agree strongly',
    //   ]
    // },
    // {
    //   'question' : 'Calm, emotionally stable.',
    //   'options': [
    //     'Disagree strongly',
    //     'Disagree moderately',
    //     'Disagree a little',
    //     'Neither agree nor disagree',
    //     'Agree a little',
    //     'Agree moderately',
    //     'Agree strongly',
    //   ]
    // },
    // {
    //   'question' : 'Conventional, uncreative.',
    //   'options': [
    //     'Disagree strongly',
    //     'Disagree moderately',
    //     'Disagree a little',
    //     'Neither agree nor disagree',
    //     'Agree a little',
    //     'Agree moderately',
    //     'Agree strongly',
    //   ]
    // },
    // {
    //   'question' : 'How much education have you completed?',
    //   'options': [
    //     'Less than high school',
    //     'High school',
    //     'University degree',
    //     'Graduate degree',
    //
    //   ]
    // },
    {
      'question' : 'What type of area did you live when you were a child?',
      'options': [
        'Rural (country side)',
        'Suburban',
        'Urban (town, city)',
      ]
    },
    {
      'question' : 'What is your gender?',
      'options': [
        'Male',
        'Female',
        'Other',
      ]
    },
    {
      'question' : 'Is English your native language?',
      'options': [
        'Yess',
        'No',
      ]
    },
    {
      'question' : 'How many years old are you?',
      'isTextInput': true,
      'inputType' : 'number'
    },
    {
      'question' : 'What hand do you use to write with?',
      'options': [
        'Right',
        'Left',
        'Both',
      ]
    },
    {
      'question' : 'What is your religion?',
      'options': [
        'Hindu',
        'Jewish',
        'Muslim',
        'Buddhist',
        'Atheist',
        'Agnostic',
        'Christian (Other)',
        'Christian (Protestant)',
        'Christian (Mormon)',
        'Christian (Catholic)',
        'Sikh',
        'Other',
      ]
    },
    {
      'question' : 'What is your sexual orientation?',
      'options': [
        'Heterosexual',
        'Bisexual',
        'Homosexual',
        'Asexual',
        'Other',
      ]
    },
    {
      'question' : 'What is your race?',
      'options': [
        'Asian',
        'Arab',
        'Black',
        'Indigenous Australian',
        'Native American',
        'White',
        'Other'
      ]
    },
    {
      'question' : 'Have you voted in a national election in the past year?',
      'options': [
        'Yes',
        'No',
      ]
    },
    {
      'question' : 'What is your marital status?',
      'options': [
        'married	',
        'Never married',
        'Currently married',
        'Previously married',
      ]
    },
    {
      'question' : 'Including you, how many children did your mother have?',
      'isTextInput': true,
      'inputType' : 'number'
    },
    {
      'question' : 'If you attended a university, what was your major ',
      'isTextInput': true,
      'inputType' : 'text'
    },
  ];

  List<dynamic?> selectedOptions =[];
  @override
  void initState(){
    super.initState();
    selectedOptions = List.filled(questionsList.length, null);
    _initializeController();
  }

  void _initializeController() {
    final text = selectedOptions[currentQuestionIndex] ?? '';
    _textController = TextEditingController(text: text);
    lastInputValue = text;
    lastQuestionIndex = currentQuestionIndex;
  }

  @override
  Widget build(BuildContext){
    final currentQuestion = questionsList[currentQuestionIndex];

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDesktop = screenWidth > 600;
    final crossAxisCount = isDesktop ? 4 : 2;
    if (lastQuestionIndex != currentQuestionIndex) {
      _initializeController();
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.38),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(screenHeight * 0.03),
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFE0F7FA), Color(0xFF80DEEA)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.135,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text("Question ${currentQuestionIndex + 1} of ${questionsList.length}",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.07,
                            ),),
                        ],
                      ),
                      Column(
                        children: [
                          Text(questionsList[currentQuestionIndex]['question'],
                          style: TextStyle(
                            fontSize: screenWidth * 0.036,
                            fontWeight: FontWeight.bold,
                          ),)
                        ]
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: currentQuestion['isTextInput'] == true
                ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  selectedOptions[currentQuestionIndex] = value;
                },
                key: ValueKey(currentQuestionIndex),
                controller: _textController,
                keyboardType: currentQuestion['inputType'] == 'number'
                    ? TextInputType.number
                    : TextInputType.text,
                inputFormatters: currentQuestion['inputType'] == 'number'
                    ? [FilteringTextInputFormatter.digitsOnly]
                    : [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))],
                decoration: InputDecoration(
                  labelText: 'Your answer',
                  border: OutlineInputBorder(),
                ),
              ),
            )
            : ListView.builder(
              itemCount: currentQuestion['options'].length,
              itemBuilder: (context, index) {
                final option = currentQuestion['options'][index];
                final isSelected = selectedOptions[currentQuestionIndex] == index;

                return Card(
                  color: isSelected ? Color(0xFF006064) : null,
                  child: ListTile(
                    leading: Checkbox(
                      value: isSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          selectedOptions[currentQuestionIndex] = index;
                        });
                      },
                    ),
                    title: Text(
                      option,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontSize: screenHeight * 0.02,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        selectedOptions[currentQuestionIndex] = index;
                      });
                    },
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 20), // Space between options and buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: currentQuestionIndex > 0
                    ? () {
                  setState(() {
                    currentQuestionIndex--;
                  });
                }
                    : null,
                child: Text('Previous'),
              ),
              ElevatedButton(
                onPressed: currentQuestionIndex < questionsList.length - 1
                    ? () {
                  setState(() {
                    currentQuestionIndex++;
                  });
                }
                    : null,
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}