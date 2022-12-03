from wordcloud import WordCloud
import matplotlib.pyplot as plt
from random import sample

dados = ["Code.exe "] * 60 + ["chrome.exe "] * 100 + ["python.exe"] *100 + ["node.exe"] *80 +["MySQLWorkbench.exe"] * 100 + ["System" ] *60 + ["explorer.exe"] *20 + ["notepad.exe"] * 20 + ["System Idle Process"] *20 + ["mysqld.exe"] * 20 
["TextInputHost.exe"] *20 + ["ctfmon.exe"] *40 + ["svchost.exe"] *20 + ["WildTangentHelperService.exe" ] *20

var = " ".join(str(x) for x in dados)

wc = WordCloud(collocations = False, background_color="white").generate(var)

fig, ax = plt.subplots(figsize=(15,11))

plt.imshow(wc, interpolation="bilinear")

plt.axis("off")

plt.show()
