from django.shortcuts import render
from surveyapp.models import Survey, Answer
from django.views.decorators.csrf import csrf_exempt

# Create your views here.
def home(request):
    dto = Survey.objects.filter(status='y').order_by('-survey_idx')[0]      # 아직 진행 중인 것만 가져오겠다는 조건걸기(where=filter)
    return render(request, 'survey_home.html', {'dto': dto})

@csrf_exempt
def save_survey(request):
    idx = request.POST["idx"]
    num = request.POST["num"]

    Answer(survey_idx=idx, num=num).save()
    return render(request, 'success.html')

def show_result(request):
    idx = request.GET["survey_idx"]
    ans = Survey.objects.get(survey_idx = idx)
    answer = [ans.ans1, ans.ans2, ans.ans3, ans.ans4]   # 이걸가지고 쿼리 작성해야함
    surveyList = Survey.objects.raw('''
        select survey_idx, num, count(num) sum_num,
            round((select count(*) from surveyapp_answer                   
            where survey_idx=a.survey_idx and num=a.num) * 100.0 /
            (select count(*) from surveyapp_answer where survey_idx=a.survey_idx), 1) rate
            from surveyapp_answer a
            where survey_idx = %s
            group by survey_idx, num order by num
    ''', idx)
    surveyList = zip(surveyList, answer)   # 결과를 tuple로 묶어준다? = zip
    #print("surveyList : ", surveyList)

    count = Answer.objects.all().count()
    return render(request, 'result.html', {"surveyList":surveyList, "count":count})


