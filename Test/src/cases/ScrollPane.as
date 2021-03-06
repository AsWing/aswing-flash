package cases
{
	import flash.display.Sprite;
	import org.aswing.*;

	public class ScrollPane extends Sprite
	{
		public function ScrollPane()
		{
			super();
			var panel:JPanel = new JPanel(new BorderLayout());
						
			var container:JPanel = new JPanel(new GridLayout(0, 8, 5, 5));
			for(var i:int=0; i<200; i++){
				container.append(new JButton("Button " + i));
			}
			var scrollPane:JScrollPane = new JScrollPane(container);
			panel.append(scrollPane, BorderLayout.CENTER);
			
			panel.setSizeWH(300, 300);
			addChild(panel);
			panel.validate();
		}
		
	}
}