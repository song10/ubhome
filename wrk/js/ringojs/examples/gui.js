var {JFrame, JButton} = javax.swing;

function main() {
    var frame = new JFrame("Hello World!");
    var button = new JButton("Bye bye");
    button.addActionListener(function(e) {
        system.exit();
    });
    frame.add("Center", button);
    frame.setSize(300, 300);
    frame.setVisible(true);
}

if (require.main == module)
    main();
